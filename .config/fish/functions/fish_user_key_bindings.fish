function fish_user_key_bindings
  # Use tab or ctrl-y for auto completion
  bind \t complete
  bind -M insert ctrl-y accept-autosuggestion
end

fish_hybrid_key_bindings
