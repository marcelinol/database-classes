desvios do SQL (postgre)
- ENUM
- tipo TEXT
- tipo SERIAL


desvios do modelo conceitual
- Profissional nao se relaciona diretamente com procedimento
- Clinica nao se relaciona diretamente com procedimento
  - Ambos se relacionam com internacao

doencas tiradas do site: http://www.bulas.med.br/cid-10

adicional
- Extraí Exame para outra tabela porque o mesmo exame pode ser útil para 2 internações diferentes (do mesmo paciente)
