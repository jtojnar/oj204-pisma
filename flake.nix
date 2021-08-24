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
          inherit (pkgs.texlive) collection-latexextra collection-luatex scheme-small luabidi;
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

        ibm-plex =
          pkgs.runCommand "ibm-plex" { } ''
            # opentype/ directory does not seem to be supported.
            install -Dt "$out/share/fonts/truetype" "${pkgs.ibm-plex}/share/fonts/opentype/"*.otf
          '';

        fonts = [
          pkgs.gentium
          ibm-plex
          david-libre
        ];

        # Add fonts
        FONTCONFIG_FILE =
          pkgs.makeFontsConf {
            fontDirectories = fonts;
          };
      in rec {
        packages = {
          inherit easytimeline;
        };
        devShell = pkgs.mkShell {
          nativeBuildInputs = [
            tex
            pkgs.pandoc
            pkgs.graphviz
            easytimeline

            # rsvg-convert is used by pandoc to convert SVGs to PDF.
            pkgs.librsvg

            # Work around librsvg hiding links
            pkgs.python3
          ];

          # Required by ploticus.
          GDFONTPATH = "${pkgs.gentium}/share/fonts/truetype";

          # For LuaLaTeX.
          OSFONTDIR = pkgs.lib.makeSearchPath "share/fonts/truetype" fonts;

          # Used by Makefile
          CITATION_STYLES = citation-styles;

          inherit FONTCONFIG_FILE;
        };
      }
    );
}
