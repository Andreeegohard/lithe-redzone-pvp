## Redzone PvP Script

### Descrizione
Questo script introduce un sistema di Redzone nel tuo server, con funzionalità avanzate per la gestione delle armi, spawn e coordinate. 

### Istruzioni per l'installazione

1. **Scarica la Risorsa:**
   - Clicca su "Code" e poi su "Download ZIP" per scaricare la risorsa.
   - Estrai la cartella `redzone-pvp` dall'archivio ZIP.

2. **Carica la Risorsa:**
   - Sposta la cartella `redzone-pvp` nella tua directory `resources`.

3. **Avvia la Risorsa:**
   - Apri il tuo `server.cfg` e aggiungi la seguente riga:
     ```
     start redzone-pvp
     ```

4. **Configurazione:**
   - Nel file `config.lua`, puoi modificare i seguenti parametri:
     - **Coordinate:** Imposta le coordinate per definire la tua Redzone.
     - **Armi:** Configura le armi che verranno assegnate ai giocatori nella Redzone.
     - **Spawn:** Definisci i punti di spawn casuali all'interno della Redzone.
     - **Redzone:** Specifica le aree e i punti della tua Redzone.

### Caratteristiche

- **Arma Automatica:** I giocatori ricevono un'arma predefinita all'entrata della Redzone.
- **Rimozione Armi:** Le armi vengono rimosse all'uscita dalla Redzone.
- **Polyzone:** Utilizzo del sistema polyzone per definire i confini della Redzone.
- **Multiple Redzone e Armi:** Supporto per più Redzone e configurazioni di armi.
- **Respawn Casuale:** I giocatori respawneranno casualmente all'interno della Redzone.
- **Invisibilità Post-Morte:** I giocatori diventano invisibili dopo la morte e il ped non è visibile.
- **Prestazioni Ottimali:** Script fluido con resmon di 0.00, senza causare lag.

### Note

Assicurati di configurare correttamente il file `config.lua` per adattare lo script alle esigenze del tuo server. 

Per ulteriori dettagli e supporto, consulta la documentazione o apri una issue.

https://discord.gg/sEB578JYtz
