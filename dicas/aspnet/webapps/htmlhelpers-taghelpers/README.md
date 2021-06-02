# HTML Helpers x Tag Helper
## HTML Helpers
HTML Helpers são utilizados em uma View para renderizar conteúdo HTML. Por exemplo, para criar um link, utilize:
```csharp
@Html.ActionLink("About the Site", "About", "Auth")
```
Será renderizado:
```html
<a href="/Auth/About">About the Site</a>
```
O Helper Html.ActionLink possui vários overloads e suporta vários parâmetros. Entre eles:
```csharp
@Html.ActionLink(linkText, actionName)
@Html.ActionLink(linkText, actionName, controllerName)
@Html.ActionLink(linkText, actionName, routeValues)
@Html.ActionLink(linkText, actionName, controllerName, routeValues)
@Html.ActionLink(linkText, actionName, routeValues, htmlAttributes)
@Html.ActionLink(linkText, actionName, controllerName, routeValues, htmlAttributes)
@Html.ActionLink(linkText, actionName, controllerName, protocol, hostname, fragment, routeValues, htmlAttributes)
```
Outros HTML Helpers podem ser encontrados em [Chapter 6 – Understanding HTML Helpers]( https://stephenwalther.com/archive/2009/03/03/chapter-6-understanding-html-helpers).
## Tag Helpers
Tag Helpers fornecem uma experiência de desenvolvimento amigável com o HTML. Para facilitar o entendimento, veja o exemplo de criação de um form:
### Exemplo 1: Forms
```html
<form method="post"
          asp-controller="Auth"
          asp-action="ExternalLogin"
          asp-route-returnUrl="@Model.ReturnUrl">
```
Será renderizado:
```html
 <form method="post" action="/Auth/ExternalLogin">
```
Observe que é possível enviar parâmetros para a Action através do Tag Helper asp-route-*, considerando que * equivale ao nome do parâmetro.
```csharp
asp-route-*
```
### Exemplo 2: Images
O **ImageTagHelper** adiciona um número de versão a uma imagem. Desta forma, sempre que a imagem alterar, o ImageTagHelper gera um novo número de versão para a imagem e desta forma é garantido que o usuário final sempre estará vendo a imagem mais recente do servidor.
```csharp
<img src="~/images/asplogo.png" asp-append-version="true">
```
Será renderizado:
```html
<img src="/images/asplogo.png?v=Kl_dqr9NVtnMdsM2MUg4qthUnWZm5T1fCEimBPWDNgM">
```
## Criação de Tag Helpers
É possível criar Tag Helpers personalizados para atender a necessidade do desenvolvedor. 

Vamos simular o cenário que o botão excluir de uma página só possa ser exibido caso o usuário autenticado possua a Claim “Produtos” com o valor definido para “Delete”.
```csharp
    /// <summary>
    /// Hide the HTML DOM if the User does not have the required Name and Value Claims
    /// </summary>
    [HtmlTargetElement("*", Attributes ="suppress-by-claim-name")]
    [HtmlTargetElement("*", Attributes ="suppress-by-claim-value")]
    public class HideElementByClaimTagHelper : TagHelper
    {
        private readonly IHttpContextAccessor _contextAccessor;

        public HideElementByClaimTagHelper(IHttpContextAccessor contextAccessor)
        {
            _contextAccessor = contextAccessor;
        }

        [HtmlAttributeName("suppress-by-claim-name")]
        public string IdentityClaimName { get; set; }
        
        [HtmlAttributeName("suppress-by-claim-value")]
        public string IdentityClaimValue { get; set; }

        public override void Process(TagHelperContext context, TagHelperOutput output)
        {
            if (context == null) 
                throw new ArgumentNullException(nameof(context));
            if (output == null) 
                throw new ArgumentNullException(nameof(context));

            var hasAccess = CustomAuthorization.ValidarClaimsUsuario(_contextAccessor.HttpContext, IdentityClaimName, IdentityClaimValue);

            if (hasAccess) return;
            output.SuppressOutput();
        }
    }
```

Método que verifica se o usuário possui a Claim e Value informados:
```csharp
public class CustomAuthorization
    {
        public static bool ValidarClaimsUsuario(HttpContext context, string claimName, string claimValue)
        {
            return context.User.Identity.IsAuthenticated &&
                   context.User.Claims.Any(c => c.Type == claimName && c.Value.Contains(claimValue));
        }
    }
```
Para utilizar o Tag Helper criado:
```html
<a 
    suppress-by-claim-name="Produtos" 
    suppress-by-claim-value="Delete" 
    asp-controller="Produtos" 
    asp-action="Delete" 
    asp-route-id="@item.Id" 
    class="btn btn-outline-info" 
    data-tooltip="tooltip" 
    title="Excluir Produto" 
    data-placement="bottom">
        <span class="fa fa-trash"></span>
</a>
```
## Sources
-	https://docs.microsoft.com/en-us/aspnet/core/mvc/views/tag-helpers/intro?view=aspnetcore-5.0
-	[desenvolvedor.io](https://desenvolvedor.io)