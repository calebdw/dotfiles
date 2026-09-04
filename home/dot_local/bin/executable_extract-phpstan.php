#!/usr/bin/env php
<?php

$vendorDir = getcwd().'/vendor';
$pharPath = "${vendorDir}/phpstan/phpstan/phpstan.phar";
$extractPath = "${vendorDir}/phpstan/phpstan-src";

if (is_file($pharPath)) {
    require "${vendorDir}/autoload.php";

    system("rm -rf {$extractPath}");

    $phar = new Phar($pharPath);
    $phar->extractTo($extractPath);
}
