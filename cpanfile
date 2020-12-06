requires 'HTTP::Tiny';
requires 'JSON::PP', '4.05';
requires 'Mouse', 'v2.5.10';
requires 'URI', '5.05';
requires 'perl', '5.008001';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'Test::More', '0.98';
};
