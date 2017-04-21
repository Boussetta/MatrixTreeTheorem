function D = inc2deg( in )
%% inc2deg function computes the degree matrix of G
% D is a diagonal matrix which contains information about the degree of
% each vertex.
% D = diag(d1, d2, ..., dn) such that di is the gedree of vertex i. that
% means di is the number of edges incident to vertex i.
D = diag(sum(in,2));
end

