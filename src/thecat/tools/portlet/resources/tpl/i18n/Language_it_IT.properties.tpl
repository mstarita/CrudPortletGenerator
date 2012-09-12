${entityName}.entity-name=${entityName}
<#list fieldList as field>						
${entityName}.field.${field.fieldName}=${field.fieldName}
</#list>

${entityName}.search.header=${className}
${entityName}.edit.header=Parametri di configurazione di ${className}
${entityName}.registry.edit.header=Modifica ${className}
${entityName}.registry.new.header=Nuova ${className}
${entityName}.registry.show.header=Visualizza ${className}

grid.summary={0} record trovati, record visualizzati {1}, da {2} a {3}. Pagina {4} / {5}.

deletion-confirm.title=Conferma della cancellazione
deletion-confirm.message=Sei sicuro di voler cancellare il record selezionato?

update.msg.success=Aggiornamento effettuato correttamente
update.msg.fail=Si e' verificato un errore nell'aggiornamento
new.msg.success=Nuovo record creato correttamente
new.msg.fail=Si e' verificato un errore nella creazione di un nuovo record
search.msg.fail=Si e' verificato un errore nella ricerca
search-after-delete.msg.fail=Si e' verificato un errore nell'aggiornamento della ricerca dopo la cancellazione
delete.msg.fail=Si e' verificato un errore nella cancellazione
edit.save.msg.success=Preferenze salvate correttamente
edit.save.msg.fail=Si e' verificato un errore nel salvataggio delle preferenze
edit.reset.msg.fail=Si e' verificato un errore nel reset delle preferenze

button.search=Cerca
button.reset=Resetta
button.new=Nuovo...
button.print=Stampa
button.show=Visualizza
button.edit=Modifica
button.delete=Elimina
button.save=Salva
button.confirm=Conferma
button.cancel=Annulla
button.selectAll=Seleziona tutto
button.deselectAll=Deseleziona tutto

searchFields=Campi di ricerca
searchFieldsOptions=Opzioni campi di ricerca
columnNumber=Numero di colonne
resultFields=Campi risultato ricerca
resultOptions=Opzioni risultato ricerca
rowsPerPage=Righe per pagina
sortField=Ordina per campo
registryFields=Campi anagrafica
registryOptions=Opzioni anagrafica
