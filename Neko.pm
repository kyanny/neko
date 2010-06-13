package Neko;
use strict;
use warnings;
use base qw(CGI::Application);
use CGI::Application::Plugin::TT;

use Text::CSV_XS;
use Template;
use Data::Dumper;

sub setup {
    my $self = shift;
    $self->start_mode('neko');
    $self->run_modes('neko' => 'do_neko');
    $self->header_props(-type => 'text/html; charset=utf-8');
}

sub do_neko {
    my $self = shift;
    my $output;

    my $csv = Text::CSV_XS->new({binary => 1});
    my $data = $self->query->param('data');

    # extract CSV
    my @rows;
    for my $line (split /\r\n|\r|\n/, $data) {
        $csv->parse($line);
        my @cols = $csv->fields;
        push @rows, \@cols;
    }
    my $labels = shift @rows;
    my @data;
    for my $cols (@rows) {
        my %line;
        @line{@$labels} = @$cols;
        push @data, \%line;
    }
    my %data;
    for my $data (@data) {
        my $category_id = $data->{category_id};
        warn $category_id;
        push @{ $data{$category_id}}, $data;
    }

    # render
    my $tt = Template->new;
    $tt->process('neko.tmpl', {data => \%data}, \my $output);
    open my $fh, '>', 'taro.html';
    print $fh $output;
    close $fh;

    return $self->tt_process('neko.html');
}

1;
