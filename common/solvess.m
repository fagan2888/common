function mins=solss(ini,zbar,fname);
options=optimset;
mins=feval(fname,[ini;ini;zbar;zbar]);
