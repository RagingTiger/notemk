## About
The **notemk** utility was originally created for the [CoDir](https://ragingtiger.github.io/CoDir/) project, but it has become clear
that it has value outside of this project

## Installation
To configure your environment to use the script follow the below steps. First
clone and cd into the **notemk** repository:

```
git clone https://github.com/RagingTiger/notemk
cd notemk/
```

Next you're going to append the shell script path to your .bashrc or .zshrc:

```
echo "# alias for notemk" >> "$HOME/.`basename $SHELL`rc"
echo "alias notemk=$PWD/notemk.sh" >> "$HOME/.`basename $SHELL`rc"
source "$HOME/.`basename $SHELL`rc"
```

To check that it worked, run the tail command:

```
tail "$HOME/.`basename $SHELL`rc"
```

You should get output like this:

```
.
.
.
# alias for notemk
alias notemk=/path/to/your/repository/notemk/notemk.sh
```

## Usage
There are two ways to use the **notemk** utility: 1. involves the use of a
`.env` file and [autoenv](https://github.com/kennethreitz/autoenv), and 2. involves simply using it without it.

The first option simply involves copying the `.env` file found in this
repository to any directory that is the root of your project directory.

The second option requires nothing on your part.

Usage of the utility is simple:

```
cd YourProject/data/
notemk
```

If you have the [autoenv](https://github.com/kennethreitz/autoenv) and the
`.env` file setup, then a file named `YourProject.data.month.day.year.txt` will
be created. Otherwise the file `data.month.day.year.txt` will be created.

Your file will be located in a 'hidden' directory named `.notes`. For example
in the first option:

```
ls YourProject/data/.notes/
YourProject.data.month.day.year.txt
```

This is what will be created and stored in the hidden `.notes` directory
