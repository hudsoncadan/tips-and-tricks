# Dicas de Python, Pandas e Machine Learning
## Python
1. [datetime](#datetime): Manipule datas e horas.
## Pandas
1. [pandas.core.groupby.GroupBy.cumcount()](#cumcount): Crie uma coluna autoincremento baseado em um grupo de colunas.
2. [pandas.cut()](#cut): Converta dados numéricos em dados categóricos.
3. [pandas.DataFrame.diff()](#diff): Calcule a diferença de valores entre cada linha de um DataFrame.
4. [pandas.DataFrame.unstack()](#unstack): Converta índices em colunas.
5. [pandas.Series.str.contains()](#strcontains): Consulte se um valor ou uma expressão regular está contida dentro de uma Series.
6. [pandas.melt()](#melt): Converta os elementos de uma lista em várias linhas no DataFrame.
## Machine Learning
1. [Categorical Variables](#categoricalvariables): Conheça 3 técnicas para trabalhar com Categorical Variables.
2. [Missing Values](#missingvalues): Conheça 3 técnicas para trabalhar com Missing Values.
3. [sklearn.pipeline.Pipeline](#pipelines): Agrupe as etapas de pré-processamento e modelagem dos dados.
4. [sklearn.model_selection.cross_val_score](#crossvalidation): Execute o processo de modelagem em diferentes subconjuntos de dados para obter várias medidas de qualidade do modelo.
<a id="datetime"></a>
## Desafios
1. [Kaggle Credit Card LinearRegression](#kaggle_creditcard_regression): Este notebook apresenta um modelo capaz de prever o Saldo (Balance) do cartão de crédito de acordo com uma série de características dos usuários. 
### datetime
Confira no arquivo [`datetime Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/python/datetime/datetime%20Notebook.ipynb):
1. Exibir datetime formatado em português
2. Converter string para datetime
3. DataFrame com coluna de data
4. Extrair dia, mês ou ano de datas armazenadas em um DataFrame
5. Criação de coluna de data a partir de colunas separadas "dia", "mês" e "ano"
6. Filtrar período de datas em DataFrame
7. Cálculo entre datas: subtrair dias, adicionar meses
8. Converter timestamp x datetime
9. Fuso horário
<a id="cumcount"></a>
### pandas.core.groupby.GroupBy.cumcount()
Confira no arquivo [`cumcount Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/pandas/cumcount/cumcount%20Notebook.ipynb):
1. Crie uma coluna autoincremento baseado em um grupo de colunas.
<a id="cut"></a>
### pandas.cut()
Confira no arquivo [`cut Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/pandas/cut/cut%20Notebook.ipynb):
1. Converta dados numéricos em dados categóricos.
<a id="diff"></a>
### pandas.DataFrame.diff()
Confira no arquivo [`diff Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/pandas/diff/diff%20Notebook.ipynb):
1. Calcule a diferença de valores entre cada linha de um DataFrame.
<a id="unstack"></a>
### pandas.DataFrame.unstack()
Confira no arquivo [`unstack Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/pandas/unstack/unstack%20Notebook.ipynb):
1. Converta os índices de um DataFrame em colunas.
<a id="strcontains"></a>
### pandas.Series.str.contains()
Confira no arquivo [`strcontains Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/pandas/strcontains/strcontains%20Notebook.ipynb):
1. Consulte se um valor ou uma expressão regular está contida dentro de uma Series.
<a id="melt"></a>
### pandas.melt()
Confira no arquivo [`melt Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/pandas/melt/melt%20Notebook.ipynb):
1. Converta os elementos de uma lista em várias linhas no DataFrame.
<a id="categoricalvariables"></a>
### CategoricalVariables:
Confira no arquivo [`categoricalvariables Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/machinelearning/categoricalvariables/categoricalvariables%20Notebook.ipynb):
1. Exclusão de colunas com Variáveis Categóricas.
2. Inclusão de valores através da técnica LabelEncoder. 
3. Inclusão de valores através da técnica OneHotEncoder.
<a id="missingvalues"></a>
### Missing Values:
Confira no arquivo [`missingvalues Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/machinelearning/missingvalues/missingvalues%20Notebook.ipynb):

Neste notebook são apresentadas 3 ténicas para trabalhar com Missing Values. Existem casos que são aplicados algoritmos de Machine Learning para prever os valores faltantes.
1. Exclusão de colunas com valores faltantes.
2. Inclusão de valores através da técnica Imputation.
3. Inclusão de valores através da técnica Imputation, com o armazenamento de quais valores foram incluídos.
<a id="pipelines"></a>
### sklearn.pipeline.Pipeline:
Confira no arquivo [`pipelines Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/machinelearning/pipelines/pipelines%20Notebook.ipynb):
1. Agrupe as etapas de pré-processamento e modelagem dos dados como se fosse uma única etapa.
<a id="crossvalidation"></a>
### sklearn.model_selection.cross_val_score:
Confira no arquivo [`crossvalidation Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/machinelearning/crossvalidation/crossvalidation%20Notebook.ipynb):
1. Ao utilizar cross-validation, nós submetemos o processo de modelagem de dados em diferentes grupos de dados com o objetivo de adquirir várias métricas da qualidade do modelo.
<a id="kaggle_creditcard_regression"></a>
### Kaggle Credit Card LinearRegression:
Confira no arquivo [`Kaggle Credit Card LinearRegression.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/desafios/kaggle/creditcard/regression/Kaggle%20Credit%20Card%20LinearRegression.ipynb):
1. Este notebook apresenta um modelo capaz de prever o Saldo (Balance) do cartão de crédito de acordo com uma série de características dos usuários.