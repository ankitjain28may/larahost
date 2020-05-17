<?php

namespace Ankitjain28may\Larahost;

use Laravel\Installer\Console\NewCommand;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Process\Process;

class LarahostCommand extends NewCommand
{
    /**
     * commands to be executed
     *
     * @var array
     */
    private $commands;

    /**
     * constructor
     *
     * @param array $commands
     */
    public function __construct(array $commands)
    {
        $this->commands = $commands;
        parent::__construct();
    }

    /**
     * Execute the command.
     *
     * @param  \Symfony\Component\Console\Input\InputInterface  $input
     * @param  \Symfony\Component\Console\Output\OutputInterface  $output
     * @return int
     */
    protected function execute(InputInterface $input, OutputInterface $output)
    {
        parent::execute($input, $output);
        $output->writeln('<info>Adding Nginx VirtualHost...</info>');

        $directory = ($input->getArgument('name')) ? getcwd().'/'.$input->getArgument('name') : getcwd();
        $name = $input->getArgument('name');
        array_push($this->commands, $name);
        $process = new Process($this->commands, $directory, null, null, null);

        if ('\\' !== DIRECTORY_SEPARATOR && file_exists('/dev/tty') && is_readable('/dev/tty')) {
            $process->setTty(true);
        }

        $process->run(function ($type, $line) use ($output) {
            $output->write($line);
        });
        return 0;
    }
}
