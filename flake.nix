{
  description = "Písma světa";

  inputs = {
    citation-styles = {
      url = "github:citation-style-language/styles";
      flake = false;
    };

    david = {
      url = "github:meirsadan/david-libre";
      flake = false;
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    mediawiki-easytimeline = {
      url = "github:wikimedia/mediawiki-extensions-timeline";
      flake = false;
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, citation-styles, david, flake-compat, mediawiki-easytimeline, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        tex = pkgs.texlive.combine {
          inherit (pkgs.texlive) collection-latexextra collection-mathscience latexmk scheme-small bidi;
        };

        easytimeline =
          pkgs.runCommand "easytimeline" {
            nativeBuildInputs = [
              pkgs.makeWrapper
            ];

            buildInputs = [
              pkgs.perl
            ];
          } ''
            install -D "${mediawiki-easytimeline}/EasyTimeline.pl" "$out/bin/easytimeline"

            cd "$out/bin"
            # Generate links in SVG
            patch < ${./easytimeline-svg-map.patch}

            patchShebangs --host "$out/bin/easytimeline"
            wrapProgram "$out/bin/easytimeline" \
              --prefix PATH : "${pkgs.lib.makeBinPath [ pkgs.ploticus ]}"
          '';

        david-libre =
          pkgs.runCommand "david-libre" { } ''
            install -Dt "$out/share/fonts/truetype" "${david}/fonts/"*.ttf
          '';

        # Add fonts
        FONTCONFIG_FILE =
          pkgs.makeFontsConf {
            fontDirectories = [
              pkgs.gentium
              david-libre
            ];
          };
      in rec {
        packages = {
          inherit easytimeline;
        };
        devShell = pkgs.mkShell {
          nativeBuildInputs = [
            tex
            pkgs.pandoc
            easytimeline
          ];

          # Required by ploticus.
          GDFONTPATH = "${pkgs.gentium}/share/fonts/truetype";

          # Used by Makefile
          CITATION_STYLES = citation-styles;

          inherit FONTCONFIG_FILE;
        };
      }
    );
}
