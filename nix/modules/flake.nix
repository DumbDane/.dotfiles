{
    description = "A template making flake";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };

    outputs = { self, nixpkgs, ... }:
        let
            system = "x86_64-linux";
            pkgs = import nixpkgs { inherit system; };
        in
            {
            defaultPackage.${system} = self.packages.${system}.init-module;

            packages.${system} = 
                {
                    init-default = 
                        pkgs.writeShellApplication {
                            name = "Init default" ;

                            runtimeInputs = with pkgs; [  ];

                            text = ''
                                cat << EOF
                                { config, lib, pkgs, ... }:
                                {
                                    imports = [
                                        ./module1.nix
                                        ./module2.nix
                                    ];

                                    module1.enable = lib.mkDefault true;
                                    module2.enable = lib.mkDefault false;

                                }
                                EOF
                                '';
                                };

                                init-module = 
                                pkgs.writeShellApplication {
                                name = "Init Module" ;

                                runtimeInputs = with pkgs; [  ];

                                text = ''
                                cat << EOF
                                { config, lib, pkgs, ... }:
                                {
                                    options = {
                                        module.enable = lib.mkEnableOption "Enables module";
                                    };

                                    config = lib.mkIf config.module.enable {
                                        environment.systemPackages = with pkgs; [ module ];
                                        programs.module.enable = true;
                                    };

                                }
                                EOF
                                '';
                        };


                };
        };

}
