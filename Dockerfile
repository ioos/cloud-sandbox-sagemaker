FROM public.ecr.aws/amazonlinux/amazonlinux:2

#
ARG NB_USER="sagemaker-user"
ARG NB_UID="1000"
ARG NB_GID="100"
RUN yum install --assumeyes python3 shadow-utils sudo which && \
    useradd --create-home --shell /bin/bash --gid "${NB_GID}" --uid ${NB_UID} ${NB_USER} && \
    yum clean all

RUN python3 -m pip install --upgrade pip


RUN python3 -m pip install --upgrade urllib3==1.26.6

RUN python3 -m pip install jupyterlab

USER ${NB_UID}
WORKDIR /home/${NB_USER}

RUN <<EOL
cd 
echo "export PATH=${PATH}:${HOME}/.local/bin:${HOME}/miniforge3/bin" >> ~/.bashrc
python3 -m pip install pipx

EOL
RUN <<EOL2
source ${HOME}/.bashrc
# pipx install jupyterlab

curl -L -O "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b -f
EOL2

RUN <<EOL3
source ${HOME}/.bashrc
conda update --yes --all
EOL3
RUN <<EOL10
source ${HOME}/.bashrc
URL=https://raw.githubusercontent.com/ioos/ioos_code_lab/main/.binder/environment.yml
curl -L -o environment.yml ${URL}
echo "  - ipykernel" >> environment.yml
conda env create --quiet --file=environment.yml
EOL10
RUN source ${HOME}/.bashrc && conda init --user bash
RUN <<EOL20
source ${HOME}/.bashrc
conda activate IOOS
python3 -m ipykernel install --user  --name IOOS --display-name "Python (ioos)"
EOL20
CMD [ "jupyter" ,"lab", "--ip 0.0.0.0", "--port 8888",   "--ServerApp.base_url='/jupyterlab/default'",   "--ServerApp.token=''",   "--ServerApp.allow_origin='*'" ]
