function [y1] = myNeuralNetworkFunction(x1)
%MYNEURALNETWORKFUNCTION neural network simulation function.
%
% Auto-generated by MATLAB, 02-Apr-2024 00:06:50.
%
% [y1] = myNeuralNetworkFunction(x1) takes these arguments:
%   x = Qx5 matrix, input #1
% and returns:
%   y = Qx1 matrix, output #1
% where Q is the number of samples.

%#ok<*RPMT0>

% ===== NEURAL NETWORK CONSTANTS =====

% Input 1
x1_step1.xoffset = [0;0;0;0;0];
x1_step1.gain = [1.70370370439781e-09;2.9999999985e-09;2;2;2];
x1_step1.ymin = -1;

% Layer 1
b1 = [2.325106225719947961;-1.194033460231906929;-0.7773442814586775107;-0.81412871304807865602;-0.034545439581812525942;0.079496381232718488219;-0.6094600658602472576;1.2115912615390960205;-1.677214245449700103;2.1171467823803551411];
IW1_1 = [-1.4768763715065680309 -0.93436411492901449982 -0.28111187353442651515 1.1017668765917780771 -0.52734380387914436827;0.87445944404460462795 -1.4998886620523939062 -0.094444308335211224481 2.1526211351941051397 -0.49321788266703048276;1.1413695493993305519 -1.1477073311435130876 -0.2220051873336378323 0.23699224256139306277 -1.5057060586694388515;1.5393112085193689786 -0.36981265941496122007 -1.1604972671987621169 -0.31295195328117408895 -1.3999572500237016381;-1.3520524864833691758 1.2707893436302060142 -0.73920720229086012143 -0.90725437934595176692 1.2795419679225703558;-0.092338105451960056369 -0.027862144960790952153 -1.5952682179511328275 1.4109491632535640093 0.81880311367297164971;-1.029521188476877569 0.12237150794849524504 -1.7205076029291164197 -0.36777476833949013235 0.11011772477735237707;0.91790744990106176715 -0.96045001575713428998 -0.70168075701280496759 -1.0852844126033307504 -1.255802128688678021;-0.20098547713726477859 1.4202834304518816566 -0.3634467524612604028 1.2206922780832529796 -1.1507273233157397918;1.6332929951729560081 0.43023722848985673783 -1.4650356242918247673 -0.22273057840916157812 -0.51673796822791762118];

% Layer 2
b2 = 0.4872172112578933012;
LW2_1 = [0.54152555490100806601 0.41226601485226987975 0.31562022332300987415 0.27644510037834435501 1.311951297897119284 0.10867572567271099881 -0.39492471530830841608 0.035807619872131296601 0.067231169605614260476 -0.068793517851940710894];

% Output 1
y1_step1.ymin = -1;
y1_step1.gain = 2;
y1_step1.xoffset = 0;

% ===== SIMULATION ========

% Dimensions
Q = size(x1,1); % samples

% Input 1
x1 = x1';
xp1 = mapminmax_apply(x1,x1_step1);

% Layer 1
a1 = tansig_apply(repmat(b1,1,Q) + IW1_1*xp1);

% Layer 2
a2 = repmat(b2,1,Q) + LW2_1*a1;

% Output 1
y1 = mapminmax_reverse(a2,y1_step1);
y1 = y1';
end

% ===== MODULE FUNCTIONS ========

% Map Minimum and Maximum Input Processing Function
function y = mapminmax_apply(x,settings)
y = bsxfun(@minus,x,settings.xoffset);
y = bsxfun(@times,y,settings.gain);
y = bsxfun(@plus,y,settings.ymin);
end

% Sigmoid Symmetric Transfer Function
function a = tansig_apply(n,~)
a = 2 ./ (1 + exp(-2*n)) - 1;
end

% Map Minimum and Maximum Output Reverse-Processing Function
function x = mapminmax_reverse(y,settings)
x = bsxfun(@minus,y,settings.ymin);
x = bsxfun(@rdivide,x,settings.gain);
x = bsxfun(@plus,x,settings.xoffset);
end
