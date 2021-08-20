FROM mtmiller/octave

RUN apt-get update \
    && apt-get install -y less \
    && apt-get install -y wget \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN wget -O signal-1.4.1.tar.gz https://octave.sourceforge.io/download.php?package=signal-1.4.1.tar.gz \
    && wget -O control-3.2.0.tar.gz https://octave.sourceforge.io/download.php?package=control-3.2.0.tar.gz
#    && wget -O io-2.4.12.tar.gz https://octave.sourceforge.io/download.php?package=io-2.4.12.tar.gz \
#    && wget -O statistics-1.4.1.tar.gz https://octave.sourceforge.io/download.php?package=statistics-1.4.1.tar.gz

ADD package_install.m package_install.m
RUN ["chmod", "+x", "package_install.m"]
RUN pwd; ls
RUN octave package_install.m
RUN ln -s /octave/bin/octave /usr/bin/octave

# create user account, and create user home dir
RUN useradd -ms /bin/bash csic

ADD Range_of_movement_octave /home/csic/Range_of_movement_octave
ADD Tools /home/csic/Tools
ADD run_pi_RoM_LBT_Exo /home/csic/
ADD run_pi_RoM_LBT_Without /home/csic/
ADD run_pi_RoM_SagittalLifting /home/csic/

# set the user as owner of the copied files.
RUN chown -R csic:csic /home/csic/

USER csic
WORKDIR /home/csic
