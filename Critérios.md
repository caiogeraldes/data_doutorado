# Critérios adicionais de busca e seleção de dados

## Critérios adicionais de busca

As regras abaixo foram incluídas no processo de busca de dados para garantir que formas analisadas de maneira errônea no processo de anotação automática realizada pelos compiladores do banco de dados Diorisis não fossem ignoradas.

- δοκέω:
	- Incluir a forma pura δόξαι
 - δέομαι:
	 - Incluir passiva de δέω
- ἐξαρκέω:
	- Incluir forma pura ἐξαρκεῖ
 - ἔξεστι:
	 - Incluir forma pura ἐξεῖναι
	 - Incluir forma pura ἐξεῖναί
	 - Incluir forma pura ἐξόν
- συμπίπτω:
	- Substituir por συμπίτνω

## Critérios adicionais de seleção

1. Critério de seleção para pronomes + particípios quando o verbo principal é *impessoal*:
	- pronome + artigo + particípio = 1 constituinte $\rightarrow$ Não entra
		- Demosthenes, Agains Aphobus 1, 60.1
	- particípio + pronome ou pronome + particípio = 2 constituintes $\rightarrow$ Entra
		- Demosthenes, Agains Boeotus 2, 5.1
2. Critério de seleção para pronomes + particípios quando o verbo principal é *pessoal*: incluir a opção mais provável e recomendar checagem posterior na coluna `CHECK`.
3. Ignorar sentenças com construções formulares tais como "hōs emoi\\(ge) dokei= / e)/oike".
4. Ignorar resultados do verbo di/dwmi salvo nos casos com formas imperativas, a construção é extremamente rara perto da quantidade de exemplos produzidos por ruído.
5. Ignorar resultados do verbo pisteu/w, *idem*.
6. Excluir sentenças regidas por dokei= com substantivos no nominativo nas imediações.
7. Excluir sentenças cuja captura da busca seja um particípio neutro precedido por artigo.
