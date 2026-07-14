# exp_RO — Banco de Dados para Teste de Reconhecimento de Objetos (RO)

Banco de dados relacional em **MySQL** desenvolvido para organizar e analisar os dados de um experimento comportamental real de laboratório, utilizando o **Teste de Reconhecimento de Objetos (RO)** — um paradigma clássico em neurociência para avaliar memória em roedores.

## 🧠 Sobre o experimento

No teste de RO, o animal é exposto a dois objetos: um **familiar** (já visto antes) e um **novo**. Se a memória do animal está intacta, ele tende a explorar mais o objeto novo — é essa diferença de tempo de exploração que indica reconhecimento.

O experimento comparou dois grupos:
- **Grupo Controle**
- **Grupo Tratamento**

O objetivo é avaliar se a intervenção testada altera a capacidade de reconhecimento (memória) dos animais em relação ao grupo controle.

## 🗄️ Estrutura do banco

| Tabela | Descrição |
|---|---|
| `experimento` | Registra a data de cada sessão experimental |
| `grupo` | Grupos experimentais (controle / tratamento), vinculados a um experimento |
| `animal` | Dados de cada rato: peso, caixa, grupo ao qual pertence |
| `dados_teste` | Tempos de exploração do objeto novo e familiar, por animal |

### Decisões de modelagem

- **Coluna virtual (`VIRTUAL`)**: o índice de discriminação — métrica central do teste — é calculado automaticamente pelo MySQL a partir da fórmula:

  ```
  indice_discriminacao = (tempo_obj_novo - tempo_obj_familiar) / (tempo_obj_novo + tempo_obj_familiar)
  ```

  Isso evita erro manual de cálculo e mantém o dado sempre consistente com os tempos brutos.

- **DECIMAL em vez de TIME**: os tempos de exploração são armazenados em segundos como `DECIMAL(6,2)`, não como `TIME`, já que são durações medidas em segundos com casas decimais — não horários.

- **Controle manual de ID em `grupo`**: diferente das outras tabelas (que usam `AUTO_INCREMENT`), o `id_grupo` é definido manualmente para carregar significado semântico consistente entre experimentos (ex: `1` = controle, `4` = tratamento em determinada rodada).

## 📁 Arquivos

- `exp_RO.sql` — script de criação do banco e das tabelas
- `exp_RO_analises.sql` — consultas de análise (JOINs, médias por grupo)
- `data/dados_animal.csv` — dados de identificação e peso dos animais
- `data/dados_teste.csv` — tempos de exploração coletados no teste

## ▶️ Como usar

1. Execute `exp_RO.sql` no MySQL Workbench (ou client de sua preferência) para criar o banco e as tabelas
2. Importe os arquivos `data/*.csv` para as tabelas `animal` e `dados_teste` (Table Data Import Wizard no Workbench, ou `LOAD DATA INFILE`)
3. Execute as consultas de `exp_RO_analises.sql` para comparar os grupos

## 📊 Exemplo de análise

```sql
SELECT id_grupo, AVG(indice_discriminacao) AS media_discriminacao
FROM dados_teste
JOIN animal ON dados_teste.id_animal = animal.id_animal
GROUP BY id_grupo;
```

Essa consulta retorna o índice de discriminação médio por grupo — a principal métrica para comparar memória entre controle e tratamento.

---

*Projeto desenvolvido a partir de dados reais de pesquisa em neurociência comportamental (memória e reconhecimento de objetos).*
