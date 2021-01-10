requires 'Encode';
requires 'Function::Parameters';
requires 'HTTP::Tiny';
requires 'JSON::PP', '4.05';
requires 'Mouse', 'v2.5.10';
requires 'URI';
requires 'perl', '5.008001';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'Test::More', '0.98';
};
