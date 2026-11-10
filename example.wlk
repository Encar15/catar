object pepita {
  var energy = 100

  method energy() = energy

  method fly(minutes) {
    energy = energy - minutes * 3
  }
}

class Plato{
  var property cantidadAzucar
  var calificacion
 
  
  method serCalificado(nuevaCalificacion) {
    calificacion = nuevaCalificacion
  }

  method calorias() = 3 * cantidadAzucar + 100

  method esBonito() = true
}

class Entrada inherits Plato(cantidadAzucar=0){
 override method esBonito() = true
}

class Principal inherits Plato{}

class Postre inherits Plato(cantidadAzucar=120){
  var property colores
  
  override method esBonito() = colores > 3
}

class Cocinero{
  var tipoCocinero

  method cocinar(){
    tipoCocinero.cocinar()
  }

  method catar(plato){
    tipoCocinero.catar(plato)
  }

}

class Pastelero{
  var nivelDulzor

  method catar(plato){
    plato.serCalificado((5 * plato.cantidadAzucar() / nivelDulzor).max(10)) 
 }

  method cocinar(){
    return new Postre(colores = nivelDulzor / 50, calificacion = 0)
 }
}

class Chef{
  var caloriasMaximas

  method catar(plato){
    if(plato.esBonito() && plato.calorias() < caloriasMaximas){
      plato.serCalificado(10)
    }
    else{
      plato.serCalificado(0)
    }
  }

  method cocinar() = new Principal(cantidadAzucar=caloriasMaximas, calificacion = 0)
}

class Souschef inherits Chef{
  override method catar(plato) {
    if(plato.esBonito() && plato.calorias() < caloriasMaximas){
      plato.serCalificado(10)
    }
    else{
      plato.serCalificado((plato.calorias() / 100).max(6))
    }
  }

  override method cocinar() = new Entrada(calificacion=0)
}

class Torneo{
  const property participaciones = []
  const property catadores = []

  method participar(cocinero){
    const platoPreparado = cocinero.cocinar()
    const participacion = new Participacion(cocinero=cocinero, plato=platoPreparado)

    participaciones.add(participacion)
  }

  method puntuacionDe(plato) {
        return catadores.sum({ catador => catador.catar(plato) })
    }

  method ganador(){
    if (participaciones.isEmpty()) {
            self.error("No se puede establecer un ganador porque no hay participantes")
        }
    else{
      const mejorParticipacion = participaciones.max({ participacion => self.puntuacionDe(participacion.plato())})

        
        return mejorParticipacion.cocinero()
    }
  }
}

class Participacion {
    const property cocinero
    const property plato
}