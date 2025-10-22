{ pkgs, config, ... }:
{
  programs.fish = {
    enable = true;

    # Disable default greeting
    interactiveShellInit = ''
      set -g fish_greeting

      # Run fastfetch on shell startup
      if status is-interactive
          fastfetch
      end

      # Clear screen function that also clears scrollback
      function clear_all
          command clear && printf '\e[3J'
      end

      # Git commit function
      function gc
          set file_status (git status --porcelain)
          git add .
          set commit_msg (test (count $argv) -eq 0; and echo "Auto-commit"; or echo "$argv[1]")
          git commit -m "$commit_msg

      $file_status"
      end

      # Tide configuration (baseado no seu config antigo)
      if type -q tide
        # Left Prompt Items
        set -g tide_left_prompt_items pwd git node rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig

        # Right Prompt Items
        set -g tide_right_prompt_items status cmd_duration context jobs direnv python rustc java php pulumi ruby go gcloud kubectl distrobox toolbox terraform aws nix_shell crystal elixir zig time

        # OS Component
        set -g tide_os_bg_color 1E1E2E
        set -g tide_os_color FF79C6
        set -g tide_os_icon

        # PWD Component
        set -g tide_pwd_bg_color 1E1E2E
        set -g tide_pwd_color FF79C6
        set -g tide_pwd_color_anchors FF79C6
        set -g tide_pwd_color_dirs F5C2E7
        set -g tide_pwd_color_truncated_dirs CBA6F7

        set -g tide_git_color_branch 663399  # Changed to darker blue

        # Status Component
        set -g tide_status_bg_color 1E1E2E
        set -g tide_status_bg_color_failure 1E1E2E
        set -g tide_status_color F5C2E7
        set -g tide_status_color_failure F38BA8

        # Command Duration Component
        set -g tide_cmd_duration_bg_color 1E1E2E
        set -g tide_cmd_duration_color F5C2E7

        # Context Component (user@host)
        set -g tide_context_bg_color 313244
        set -g tide_context_color_default F5C2E7
        set -g tide_context_color_root F38BA8
        set -g tide_context_color_ssh FF79C6

        # Jobs Component
        set -g tide_jobs_bg_color 1E1E2E
        set -g tide_jobs_color CBA6F7

        # Time Component
        set -g tide_time_bg_color 1E1E2E
        set -g tide_time_color F5C2E7

        # Node.js Component (for Angular)
        set -g tide_node_bg_color 313244
        set -g tide_node_color F38BA8
        set -g tide_node_icon ⬢

        # Python Component
        set -g tide_python_bg_color 313244
        set -g tide_python_color CBA6F7

        # Ruby Component
        set -g tide_ruby_bg_color 313244
        set -g tide_ruby_color F38BA8

        # Go Component
        set -g tide_go_bg_color 313244
        set -g tide_go_color 94E2D5

        # Rust Component
        set -g tide_rustc_bg_color 313244
        set -g tide_rustc_color FAB387

        # PHP Component
        set -g tide_php_bg_color 313244
        set -g tide_php_color CBA6F7

        # Java Component
        set -g tide_java_bg_color 313244
        set -g tide_java_color FAB387

        # Kubectl Component
        set -g tide_kubectl_bg_color 313244
        set -g tide_kubectl_color 89B4FA

        # AWS Component
        set -g tide_aws_bg_color 313244
        set -g tide_aws_color FAB387

        # Terraform Component
        set -g tide_terraform_bg_color 313244
        set -g tide_terraform_color CBA6F7

        # Docker Component
        set -g tide_docker_bg_color 313244
        set -g tide_docker_color 89B4FA

        # Character Component
        set -g tide_character_color F5C2E7
        set -g tide_character_color_failure F38BA8
        set -g tide_character_icon ❯
        set -g tide_character_vi_icon_default ❮
        set -g tide_character_vi_icon_replace ▶
        set -g tide_character_vi_icon_visual V

        # Vi Mode Component
        set -g tide_vi_mode_bg_color_default 313244
        set -g tide_vi_mode_bg_color_insert 313244
        set -g tide_vi_mode_bg_color_replace 313244
        set -g tide_vi_mode_bg_color_visual 313244
        set -g tide_vi_mode_color_default F5C2E7
        set -g tide_vi_mode_color_insert A6E3A1
        set -g tide_vi_mode_color_replace F38BA8
        set -g tide_vi_mode_color_visual CBA6F7

        # Private Mode Component
        set -g tide_private_mode_bg_color 313244
        set -g tide_private_mode_color F5C2E7

        # Prompt configuration
        set -g tide_prompt_add_newline_before true
        set -g tide_prompt_min_cols 34
        set -g tide_prompt_pad_items true

        # Separators para estilo powerline
        set -g tide_left_prompt_separator_diff_color
        set -g tide_left_prompt_separator_same_color
        set -g tide_right_prompt_separator_diff_color
        set -g tide_right_prompt_separator_same_color

        # Frame
        set -g tide_left_prompt_frame_enabled false
        set -g tide_right_prompt_frame_enabled false
      end

      # Initialize zoxide - ADICIONADO BASEADO NO SEU COMANDO
      if command -q zoxide
        zoxide init fish | source
      end
    '';

    shellAliases = {
      # Clear aliases (do seu config antigo)
      cls = "clear_all";
      c = "clear";
      cc = "clear_all";
      clear = "clear_all";

      # lsd aliases - moderno ls com ícones
      ls = "lsd";
      ll = "lsd -l";
      la = "lsd -la";
      lt = "lsd --tree";

      # yay alias (você usava pikaur no Arch)
      yay = "nh";


      # Rebuild alias
      fkr = "sudo nixos-rebuild switch --flake .#default";
    };

    # Fish plugins - APENAS OS OFICIAIS DO NIXPKGS
    plugins = [
      {
        name = "tide";
        src = pkgs.fishPlugins.tide.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
    ];

    # Shell init para adicionar npm global bin ao PATH
    shellInit = ''
      # Add npm global packages to PATH if not already there
      if not contains $HOME/.npm-global/bin $PATH
          set -gx PATH $HOME/.npm-global/bin $PATH
      end

      # DankMaterialShell socket
      if test -n "$XDG_RUNTIME_DIR"
          set -gx DMS_SOCKET "$XDG_RUNTIME_DIR/dms.sock"
      end
    '';
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "zeditor";
  };

  # Adicionar pacotes necessários para os plugins funcionarem
  home.packages = with pkgs; [
    fzf
    fd
    bat
    lsd  # LSDeluxe - ls moderno com ícones e cores
    eza  # modern replacement for exa (backup)
    zoxide  # IMPORTANTE: instalar o zoxide
    gum     # Para alguns plugins
    delta   # Para git diffs melhores
    # Pacotes para melhorar autocompletion e correção
    bash-completion  # Para comandos bash
    nix-bash-completions  # Completions para Nix
    pay-respects  # Substituto do thefuck - correção de comandos
    # Para command-not-found funcionar
    nix-index  # Indexa pacotes para sugestões automáticas
  ];

  # Configurar zoxide NATIVO do Home Manager (mais confiável)
  programs.zoxide = {
    enable = true;
    enableFishIntegration = false;  # Desabilitar integração automática pq vamos fazer manual
  };
}
