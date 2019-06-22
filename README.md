# Dicas de Python, Pandas e Machine Learning
## Python
1. [datetime](#datetime): Manipule datas e horas.
## Pandas
1. [pandas.core.groupby.GroupBy.cumcount()](#cumcount): Crie uma coluna autoincremento baseado em um grupo de colunas.
2. [pandas.DataFrame.diff()](#diff): Calcule a diferença de valores entre cada linha de um DataFrame.
3. [pandas.DataFrame.unstack()](#unstack): Converta índices em colunas.
4. [pandas.Series.str.contains()](#strcontains): Consulte se um valor ou uma expressão regular está contida dentro de uma Series.
<a id="datetime"></a>
## Machine Learning
1. [`Missing Values`](#missingvalues): Conheça 3 técnicas para trabalhar com Missing Values.
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
<a id="diff"></a>
1. Crie uma coluna autoincremento baseado em um grupo de colunas.
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
<a id="missingvalues"></a>
### Missing Values:
Confira no arquivo [`missingvalues Notebook.ipynb`](https://github.com/hudsoncadan/python-tips/blob/master/dicas/machinelearning/missingvalues/missingvalues%20Notebook.ipynb):

Neste notebook são apresentadas 3 ténicas para trabalhar com Missing Values. Existem casos que são aplicados algoritmos de Machine Learning para prever os valores faltantes.
1. Exclusão de colunas com valores faltantes.
2. Inclusão de valores através da técnica Imputation.
3. Inclusão de valores através da técnica Imputation, com o armazenamento de quais valores foram incluídos.