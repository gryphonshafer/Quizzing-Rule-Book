requires 'exact', '>= 1.13';
requires 'exact::cli', '>= 1.03';
requires 'exact::conf', '>= 1.03';

requires 'Date::Format', '>= 2.24';
requires 'Mojolicious', '>= 8.59';
requires 'PDF::WebKit', '>= 1.2';
requires 'Text::MultiMarkdown', '>= 1.000035';

on 'test' => sub {
    requires 'Test2::V0', '0.000139';

    requires 'Test::EOL';
    requires 'Test::NoTabs';
    requires 'Test::Portability::Files';
    requires 'Text::Gitignore';

    requires 'Cwd';
    requires 'Bible::Reference', '>= 1.05';
    requires 'English::Script', '>= 1.03';
};
