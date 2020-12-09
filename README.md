This repository contains different VIO systems of the state-of-the-art that were evaluated in an agricultural environment by means of the [Rosario Dataset](https://www.cifasis-conicet.gov.ar/robot/doku.php). As an example, some outputs regarding the sequence01 can be seen here:

![trajectories_sequence_01.png](support_files/media/trajectories_sequence_01.png)
<!---
Esta imagen podría cambiarse, quizás poniendo alguna que usemos para el paper.
Sino, creo que estaría bueno poner un gif con múltiples visualizaciones tipo de debugging de cada sistema corriendo de forma sincronizada sobre alguna secuencia.
--->

# Publication

If you use this in some academic work, please cite the related publication:

R. Comelli, J. Cremona, T. Pire, [**Evaluation of VIO Systems in Agricultural Environment**](https://arxiv.org/abs/1910.02490). Some Journal, 2020?.
<!---
Autores ordenados alfabéticamente?
--->
 
```bibtex
 @InProceedings{ComelliCremona2020VioRosDat,
   title = {Evaluation of VIO Systems in Agricultural Environment},
   author = {Comelli, Román and Cremona, Javier and Pire, Taihú},
   year = {2020?},
   booktitle = {Some Journal},
   url = {Some github URL},
   pdf = {Some URL}
 }
```
<!---
Obviamente hay que actualizar esto.
--->

# Context

As stated above, this repository has several VIO pipelines that were assessed as part of the mentioned publication. Through the provided scripts and containerized submodules, it allows to repeat the tests done in a systematic and simple way (clearly the results could vary up to some point, depending on the hardware platform and due to the random nature of some algorithms internally used by the systems).

The repository is also intended to serve as a base for further progress in the development of more accurate and robust VIO and SLAM systems, specially for the agricultural environment. Modifying the source code of the already included submodules or adding and comparing other systems is what we expect and encourage the academic community to do.

<!---
No sé si faltaría alguna aclaración sobre que las modificaciones al código fuente deben hacerse respetando las respectivas licencias.
--->

# Dependencies

It is necessary to have installed:

* Docker
* ROS
* [pose_listener](https://github.com/jcremona/pose_listener)

It was everything tested in Ubuntu 16.04, 18.04 and 20.04. We suggest to follow [the steps](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user) to manage Docker as a non-root user to make it easier to run the scripts. With respect to the ROS versions, Kinetic, Melodic and Noetic have been used with their respective Ubuntu's versions. [pose_listener](https://github.com/jcremona/pose_listener) is a simple ROS node developed to capture the systems' outputs.

<!---
Puse 20.04 porque tengo entendido que Javier tiene esa versión instalada. Y la 16.04 la tengo instalada yo en una compu vieja, aunque no hice demasiadas pruebas allí realmente (sí buildié todas las imágenes).
--->

We also recommend to have [evo](https://github.com/MichaelGrupp/evo) installed in order to visualize and calculate the errors of the estimated trajectories.

# Use

To clone the repository, execute this:

```bash
git clone git@repositorio.cifasis-conicet.gov.ar:robotica/slam_agricultural_evaluation.git
cd slam_agricultural_evaluation
git submodule update --init --recursive
```
<!---
También habrá que actualizar esto cuando se suban las cosas al Github del CIFASIS supongo
--->

Once this is done (it may take some time), we are ready to build the images and download the Rosario Dataset rosbags. For this and the rest of the things that can be done, the `evaluation.config` file is provided. It defines which modules will be taken into account when building or launching the containers, what sequences will be used or downloaded (and where), where the local catkin workspace will be and the ROS version used, among other things.

So, to download all the sequences and store them in `${HOME}/datasets/robot_desmalezador` (the default), just run:

```bash
download_rosbags.sh
```

Of course, it could be omitted if the rosbags were downloaded previously. It would be enough to set their location in `evaluation.config`. To build the images of the different systems (this may take more time), execute:

```bash
build_images.sh
```

Then, if a local ROS workspace with pose_listener installed is missing, we provide `create_workspace.sh` to make it in the repository directory. Just execute:

```bash
create_workspace.sh
```

Otherwise, the path to that local ROS workspace should be set in `evaluation.config`. And finally, the tests can be done (and redone) by running:

```bash
run_containers.sh
```

The outputs of the systems will be saved in the `outputs/` directory of each submodule, with a script to plot the results (using [evo](https://github.com/MichaelGrupp/evo)).

# Development

To ease the development, each submodule has some scripts (used by the scripts located in the root of this repository) that allow to build the Docker images and run the systems in visualization or development modes. Their `README.md`s explain this.
<!---
Quizás falta una explicación más global de cómo funciona todo, podría agregarlo. Me desentendí un poco de eso porque Javier lo explicó muy bien en los README.md de cada submódulo.
También se podría agregar alguna recomendación si se va a correr en computadoras con 8 GB de RAM o menos, de reducir la cantidad de jobs de make, porque sino se queda sin RAM y hace un desastre con el swap.
--->

# TODO

* Update links when moving to CIFASIS's Github