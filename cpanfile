requires 'Date::Format', '2.24';
requires 'Mojolicious', '9.01';
requires 'PDF::WebKit', '1.2';
requires 'Text::MultiMarkdown', '1.000035';
requires 'exact', '1.17';
requires 'exact::cli', '1.05';
requires 'exact::conf', '1.05';

on test => sub {
    requires 'Bible::Reference', '1.07';
    requires 'Cwd', '3.75';
    requires 'English::Script', '1.05';
    requires 'Test2::V0', '0.000139';
    requires 'Test::EOL', '2.02';
    requires 'Test::NoTabs', '2.02';
    requires 'Test::Portability::Files', '0.10';
    requires 'Text::Gitignore', '0.04';
};
