%% version1.m

%    Copyright © 2017 by Wissem Boussetta
%
%    This file is part of the Matrix-Tree Theorem package used to compute
%    the number of spanning trees in directed or undirected graph.
%
%    Matrix-Tree Theorem package is free software: you can redistribute it 
%    and/or modify it under the terms of the GNU General Public License as 
%    published by the Free Software Foundation, either version 3 of the 
%    License, or (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.

function [K, a] = version1( incidence_matrix )
%% Matrix-Tree Theorem, Version 1
A = incidence2adjacency( incidence_matrix );
D = incidence2degree( incidence_matrix );
L = Laplacian( D, A );
n = size(L,1);
a = eig(L);
sort(a,'ascend');
K = (1/n) * prod(a(2:length(a))); 
end
function adjacency_matrix = incidence2adjacency( incidence_matrix )
%% UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%   TODO: verify that input is an incidence matrix

mInc = incidence_matrix;

if (~issparse(mInc))
    mInc = sparse(mInc);
end

mInc = mInc.';
vValues = sort(mInc(:));        %
idx = [diff(vValues);1]~=0;     % faster than 'unique' function in matlab
vValues = vValues(idx);         %

if (~(isequal(vValues,[0;1]) || ...     %undirected graph
        isequal(vValues,[-1;0;1])))         %directed graph
    error('inc2adj:wrongMatrixInput','Matrix must contain only {-1,0,1}');
end

L = incidence_matrix * incidence_matrix';   % Laplacian
adjacency_matrix = L - diag(diag(L));
end
function D = incidence2degree( incidence_matrix )
%% incidence2degree function computes the degree matrix of G
% D is a diagonal matrix which contains information about the degree of
% each vertex.
% D = diag(d1, d2, ..., dn) such that di is the gedree of vertex i. that
% means di is the number of edges incident to vertex i.
D = diag(sum(incidence_matrix,2));
end
function L = Laplacian( D, A )
%% This function computes the Laplacianmatrix of an undirected graph G.
% Notes::
% The Laplacian matrix L of G is equal to D -A, where:
% D is the degree matrix of G
% A is the adjacency matrix of G

L = D - A;
end