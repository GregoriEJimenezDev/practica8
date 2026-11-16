# Practica 8: laboratorio de automatizacion con Ansible

Este repositorio contiene un laboratorio reproducible para practicar la administracion de varios servidores Ubuntu desde un solo equipo. Los servidores se ejecutan como contenedores Docker y Ansible se conecta a ellos mediante SSH.

## Objetivos

- Levantar tres nodos Linux aislados con Docker Compose.
- Definir los destinos administrables mediante un inventario de Ansible.
- Ejecutar tareas repetibles con un playbook.
- Crear usuarios, instalar utilidades y publicar informacion del sistema.
- Comprobar el resultado sin conectarse manualmente a cada nodo.

## Archivos principales

| Ruta | Proposito |
| --- | --- |
| `Dockerfile` | Construye la imagen Ubuntu con SSH, Python y el usuario de automatizacion. |
| `docker-compose.yml` | Inicia los tres contenedores del laboratorio. |
| `ansible.cfg` | Indica el inventario y algunos valores de conexion. |
| `inventario.ini` | Asocia cada nodo con su puerto SSH local. |
| `playbooks/preparar_nodos.yml` | Define las tareas que se aplican a todos los nodos. |

## Requisitos

- Docker Engine o Docker Desktop con Compose.
- Ansible instalado en el equipo anfitrion.
- `sshpass` para la autenticacion del inventario de practica.

En Ubuntu, Ansible y `sshpass` pueden instalarse con:

```bash
sudo apt update
sudo apt install -y ansible sshpass
```

## Puesta en marcha

1. Inicia los contenedores:

   ```bash
   docker compose up -d --build
   ```

2. Comprueba que Ansible alcanza los tres nodos:

   ```bash
   ansible nodos -m ping
   ```

3. Ejecuta la configuracion:

   ```bash
   ansible-playbook playbooks/preparar_nodos.yml
   ```

4. Verifica los cambios:

   ```bash
   ansible nodos -b -m command -a 'id laboratorio'
   ansible nodos -b -m command -a 'cat /srv/practica8/estado.txt'
   ansible nodos -b -m command -a 'tree -L 1 /srv/practica8'
   ```

Para apagar el laboratorio:

```bash
docker compose down
```

## Nota de autoria

La practica fue elaborada de forma independiente para `practica8`, tomando como referencia el objetivo general del proyecto publico [Ansible-para-automatizar-tareas](https://github.com/TheProdigi/Ansible-para-automatizar-tareas-Jean-Carlos-C.-2025-1380). La estructura, nombres, puertos, playbook y redaccion de este repositorio son propios.