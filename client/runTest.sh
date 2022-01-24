#!/bin/sh


#Search Asset Tests
#vendor/bin/phpunit --bootstrap vendor/autoload.php --testdox test/EnterMedia/Test/Test.php

#Update Asset Test
vendor/bin/phpunit --verbose --bootstrap vendor/autoload.php --testdox test/EnterMedia/Test/TestUpdate.php
