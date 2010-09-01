
use strict;
use Plack::Test;
use Test::More tests => 12;
use lib "./t/MyApp/lib";
use MyApp;

# TT view
test_psgi
    app => MyApp->handler,
    client => sub {
        my $cb = shift;
        my $req = HTTP::Request->new( GET => 'http://localhost/foo/bar' );
        my $res = $cb->( $req );
        is $res->code, '200';
        like $res->content, qr{Foo/Bar}, 'check content';
        like $res->content, qr{MyApp - Template}, 'check content';
        like $res->content, qr{var1}, 'check content';
    } ;

# MT view
test_psgi
    app => MyApp->handler,
    client => sub {
        my $cb = shift;
        my $req = HTTP::Request->new( GET => 'http://localhost/foo/bar?view=MT' );
        my $res = $cb->( $req );
        is $res->code, '200';
        like $res->content, qr{Foo/Bar}, 'check content';
        like $res->content, qr{MyApp - MicroTemplate}, 'check content';
        like $res->content, qr{var1}, 'check content';
    } ;

# Xslate view
test_psgi
    app => MyApp->handler,
    client => sub {
        my $cb = shift;
        my $req = HTTP::Request->new( GET => 'http://localhost/foo/bar?view=Xslate' );
        my $res = $cb->( $req );
        is $res->code, '200';
        like $res->content, qr{Foo/Bar}, 'check content';
        like $res->content, qr{MyApp - Xslate}, 'check content';
        like $res->content, qr{var1}, 'check content';
    } ;
