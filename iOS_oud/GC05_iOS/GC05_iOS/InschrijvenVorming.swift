class InschrijvingVorming {
    
    // ID?
    let begindatum: datum
    let einddatum: datum
    let monitor: Monitor
    let vakantie: Vakantie
    
    init(begindatum: datum, einddatum: datum, monitor: Monitor, vakantie: Vakantie) {
        self.begindatum = begindatum
        self.einddatum = einddatum
        self.monitor = monitor
        self.vakantie = vakantie
    }
}