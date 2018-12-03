# MIST App

Questo progetto sviluppato in Swift, permette di ottenere risultati della QoS del proprio servizio di accesso a Internet, 
secondo le metodologie di valutazione descritte dal BEREC nel documento ufficiale, consultabile qui: 

https://berec.europa.eu/eng/document_register/subject_matter/berec/regulatory_best_practices/methodologies/7295-berec-net-neutrality-regulatory-assessment-methodology

### Prerequisiti

Per riuscire ad ottenere misure sul throughput dati, sarà necessario installare un server di test in grado di supportare i servizi http e posizionare all'interno della "Webserver directory index" (dove è presente il file index.html) una directory con all'interno 4 file senza estensione della dimensione di 15MB 150MB 1500MB 512MB (I file possono essere generati del sito web https://pinetools.com/random-file-generator, IMPORTANTE è rimuovere l'estensione dal file generato e rinominarli rispettivamente come segue: "10MbpsX12", "100MbpsX12", "1000MbpsX12", "1000Mbps").

Mentre sulla macchina dove si vuole eseguire l'App, occorre posizionare i medesimi file all'interno della directory 
"Users/NOME_UTENTE/Documents/".

### Installazione

Clonare il progetto su xCode, e settare nel file "ViewController.swift" le costanti "ipUrl" e "stringUrl", che rappresentano rispettivamente l'ip per eseguire l'algoritmo di calcolo della latenza media, mentre la seconda costante rappresenta l'URL per raggiungere la directory con i file necessari all'esecuzione dei test, posizionati all'interno della "Webserver directory index" del server di test scelto.

## Avvio dei test

Per eseguire dei test, una volta completate la fase dei prerequisiti e la fase di intallazione, basterà avviare avviare l'App da simulatore

## Autore
Giuliano Pes
