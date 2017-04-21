%    Cayley.m

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

function [ K ] = Cayley( in )
% In mathematics, Cayley's formula is a result in graph theory named
% after Arthur Cayley.
%
% It states that for every positive integer n, the number of trees on n
% labeled vertices is n^{n-2}.
%
% The formula equivalently counts the number of spanning trees of a
% complete graph with labeled vertices (sequence A000272 in the OEIS).
%
% a complete graph is a simple undirected graph in which every pair of
% distinct vertices is connected by a unique edge.
%
% A complete digraph is a directed graph in which every pair of distinct
% vertices is connected by a pair of unique edges (one in each direction).

if nargin < 1
    error('MatrixTreeTheorem.Cayley::nargin < 1')
end

%% if in is the number of vertex in the graph
if isequal(size(in),[1, 1])
    K = in ^ (in - 2);
    return
end

%% in the case : in is the incidence matrix
% at this level, we need to check the structure of the graph i.e. check if
% the graph is complete.
% n is the number of vertices
n = size(in,1);
% the number of edges in a complete graph with n vertices is given by the
% formula edges = n * (n - 1) / 2
edges = n * (n - 1) / 2;
% first check if the graph has the correct number of edges
if ~isequal(size(in,2), edges)
    error('MatrixTreeTheorem.Cayley::The Graph do not have the correct number of edges')
end
% now we need to check that D = (n-1)*I. Where:
% D is the degree matrix relative to the graph
% I is the identity matrix
I = eye( n );
D = MatrixTreeTheorem.inc2deg( in );
if ~isequal(D, (n - 1) * I)
    error('MatrixTreeTheorem.Cayley::The Graph is not a complete graph')
end
%% Compute the number of spanning trees
K = n ^ (n - 2);
end
