import os
import argparse

base = \
"""FROM {source_image}
CMD ["/bin/bash"]

"""

root_installs = ['install_scripts/libs.sh',
                 'install_scripts/python_libs.sh']
user_installs = ['install_scripts/glpk.sh',
                 'install_scripts/ipopt.sh']

def create_dockerfile(source_image,
                      python_exe,
                      dirname,
                      openmpi=False,
                      mpich=False):
    assert openmpi ^ mpich
    out = base.format(source_image=source_image)
    # if the executable is not 'python', then
    # create a symlink
    if python_exe != 'python':
        out += ('RUN ln -s "$(which {python_exe})" '
                '/usr/local/bin/python\n'.\
                format(python_exe=python_exe))
    if openmpi:
        out += ('ARG MPILIBS="openmpi-bin openmpi-common libopenmpi-dev"\n')
    else:
        assert mpich
        out += ('ARG MPILIBS="libmpich-dev mpich mpich-doc"\n')
    for fname in root_installs:
        with open(fname) as f:
            out += f.read()
    out += ("RUN useradd -ms /bin/bash user\n")
    out += ('USER user\n')
    out += ('WORKDIR /home/user\n')
    # destination for downloaded source code
    out += ('ARG PREFIX=/home/user\n')
    for fname in user_installs:
        with open(fname) as f:
            out += f.read()
    if not os.path.exists(dirname):
        os.makedirs(dirname)
    with open(os.path.join(dirname,'Dockerfile'),'w') as f:
        f.write(out)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        'source_image',
        help='The source image to start from')
    parser.add_argument(
        'python_exe',
        help=('The name of the python executable '
              'found in the source image'))
    parser.add_argument(
        'dirname',
        help=('The name of the output directory '
              'where the Dockerfile should be placed'))
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument('--openmpi',
                       action='store_true')
    group.add_argument('--mpich',
                       action='store_true')
    args = parser.parse_args()
    create_dockerfile(args.source_image,
                      args.python_exe,
                      args.dirname,
                      openmpi=args.openmpi,
                      mpich=args.mpich)
