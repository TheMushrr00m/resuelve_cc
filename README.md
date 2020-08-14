# ResuelveCc

Solución del code challenge "Prueba Ingeniería Backend" de "Resuelve tu Deuda"
API creada con Elixir :heart: (Plug+Cowboy)


## Requerimientos

Usados durante el desarrollo
- Elixir 1.10.4
- Erlang 11.0.3
- OTP 23

## Dependencias

```elixir
defp deps do
  [
    {:plug_cowboy, "~> 2.0"},
    {:jason, "~> 1.2"}
  ]
end
```

## Producción

Es necesario crear un archivo de configuración llamado prod.exs dentro de la carpeta config, que debe tener un contenido similar a:

```elixir
use Mix.Config

config :resuelve_cc, port: 4001
```
donde se debe establecer el puerto deseado para que el servidor pueda recibir las peticiones.

```bash
# Según el método elegido para realizar el despliegue, puede realizarse de formas diferentes, esto ya sea si se trabaja con Releases, Destillery, Docker, Kubernetes, etc.

# Para que sea accesible más fácilmente y resulte más amigable a los clientes
# el consumir el servicio, se recomienda configurar un
# reverse-proxy y/o un API Gateway como Nginx, HAProxy o Envoy
# para manejar temas de balanceo de carga, definición de un DNS para el servicio, etc.

# En el caso más simple, donde únicamente vamos a vaciar nuestro proyecto
# en el servidor, y ejecutarlo, se realiza con:

# Obtener las dependencias
$ mix deps.get

# con esto nuestro servidor se encontrará listo para recibir peticiones.
$ mix run --no-halt
```


## Desarrollo

Para ejecutar en una máquina local:

```bash
# Debemos estar posicionados dentro de este proyecto en la terminal

# Obtener las dependencias
$ mix deps.get

# Iniciar el servidor
$ iex -S mix
```

## Testing

Para ejecutar las pruebas unitarias:

```bash
# Debemos estar posicionados dentro de este proyecto en la terminal

$ mix test
```

## Endpoints (Dev y Test)

Se cuenta con un endpoint para validar la salud del servicio y verificar que se encuentre corriendo de forma correcta.

Se debe sustituir la variable `${port}` por el puerto especificado en la configuración, dependiendo el ambiente en el que se está ejecutando.
- Dev: 4001
- Test: 4002

```text
GET http://localhost:${port}/_health
```

Para obtener el sueldo de los jugadores, basandose en la información de su equipo, es necesario enviar un payload similar al del ejemplo. [Aquí puede encontrarlo](./spec/fixtures/v1/request.json).

Se debe sustituir la variable `${port}` por el puerto especificado en la configuración, dependiendo el ambiente en el que se está ejecutando.
- Dev: 4001
- Test: 4002

```text
POST http://localhost:${port}/v1/payroll
```