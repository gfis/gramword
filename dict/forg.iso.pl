while (<>) {
    s/Forg([A-Z][a-z])/Forg\.$1/g;
    print;
}
