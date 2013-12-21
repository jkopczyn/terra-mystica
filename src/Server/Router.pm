package Server::Router;

use Server::AppendGame;
use Server::ListGames;
use Server::Plan;
use Server::ViewGame;

use CGI::PSGI;
use JSON;

my %paths = (
   '/view-game/' => sub {
       Server::ViewGame->new()
    },
   '/append-game/' => sub {
       Server::AppendGame->new()
    },
   '/list-games/' => sub {
       Server::ListGames->new()
    },
   '/plan/' => sub {
       Server::Plan->new()
    },
);

sub route {
    my $env = shift;
    my $q = CGI::PSGI->new($env);

    my $path_info = $q->path_info();
    my $handler = $paths{$path_info};
    my $ret;

    eval {
        if ($handler) {
            my $app = $handler->();
            $app->handle($q);
            $ret = $app->output_psgi();
        } else {
            die "Unknown module '$path_info'";
        }
    }; if ($@) {
        $ret = [500,
                ["Content-Type", "application/json"],
                [encode_json { error => $@ }]];
    }

    $ret;
};

sub psgi_router {
    route(@_);
}

1;
