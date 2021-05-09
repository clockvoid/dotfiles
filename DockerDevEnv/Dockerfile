FROM archlinux

RUN pacman -Sy
RUN yes | pacman -S neovim tmux zsh git python python2 python-pip python2-pip ruby nodejs npm clang make
RUN mkdir /home/clock
RUN useradd -d /home/clock -G wheel clock
RUN echo "wheel ALL=(ALL) ALL" > /etc/sudoers
RUN chown clock /home/clock

WORKDIR /home/clock
USER clock
RUN mkdir git
WORKDIR /home/clock/git
ENV DOCKER=archlinux
RUN git clone https://github.com/clockvoid/dotfiles
RUN cd dotfiles \
    && bash install.sh -c neovim \
    && bash install.sh -c tmux \
    && bash install.sh -c zsh

CMD ["tmux"]
WORKDIR /home/clock

