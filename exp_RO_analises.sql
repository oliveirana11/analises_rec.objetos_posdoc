use exp_ro;
#SELECT dados_teste.id_animal, indice_discriminacao, id_grupo 
#FROM dados_teste
#JOIN animal ON dados_teste.id_animal = animal.id_animal; 
# Join diz ao mysql como as tabelas se conectam
# O ON especifica a condição de ligação — no caso, o id_animal que existe nas duas tabelas.

#Médias por grupo
#SELECT id_grupo, AVG(indice_discriminacao)
#FROM dados_teste
#JOIN animal ON dados_teste.id_animal = animal.id_animal
#GROUP BY id_grupo;
