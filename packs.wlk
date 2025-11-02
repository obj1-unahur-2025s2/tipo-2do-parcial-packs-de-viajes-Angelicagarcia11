class Pack{
    var duracion
    var precioBase
    const beneficios = []
    var coordinador
    method beneficioVigente()= beneficios.filter({b=>b.estaVigente()})
    method  costoFinal() = precioBase + self.beneficioVigente().sum({b=>b.costo()})
    method esPremium()
}




class PackNacional inherits Pack{
    var property provincia
    const property actividades = #{}
    override method esPremium()=  (duracion>10) && coordinador.esAltamenteCalificado()

}

class PackProvincial inherits PackNacional{
    const cantCiudadesAVisitar
    override method esPremium()= (cantCiudadesAVisitar > 5) && (actividades.size()>3) && (self.beneficioVigente().size()>=3)
    override method costoFinal() {
        return if (self.esPremium()) {
            super() * 1.05
        } else {
            super()
        }
    }

}


class PackInternacional inherits Pack{
    var destino
    var cantidadDeEscalas
    var esInteres
    override method costoFinal()=super() * 1.2
    override method esPremium()= esInteres && (duracion >20) && (cantidadDeEscalas==0)

}

class Coordinador{
    var cantidadDeViajes
    var estaMotivado
    var experiencia
    var rol
    const rolesValidos= #{guia, asistente, acompaniante}
    method rol()=rol
    method cambiarRol(unRol){
        if(not rolesValidos.contains(unRol)){
            self.error("Rol invalido")
        }else{
            rol = unRol

        }
    }
    method experiencia()=experiencia
    method estaMotivado() = estaMotivado
    method esAltamenteCalificado() = (cantidadDeViajes>20) and rol.condicionAdicional(self)

}


object guia {
    method condicionAdicional(unCoordinador)= unCoordinador.estaMotivado()

}


object asistente{
    method condicionAdicional(unCoordinador)= unCoordinador.experiencia()>=3


}


object acompaniante{
    method condicionAdicional(unCoordinador)= true
}


object otro{

}

class Beneficio{
    var tipo
    var costo
    var estaVigente

    method costo() = costo
    method estaVigente() = estaVigente
    method beneficioHabilitado(){estaVigente=true}
    method beneficioCancelado() {estaVigente=false}
}
