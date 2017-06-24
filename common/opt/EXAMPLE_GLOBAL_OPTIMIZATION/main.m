% clc
% clear all
close all

% update paths

addpath('./SIMPSA/')
addpath('./SCE/')
addpath('./PSO/')

% define initial conditions

init = [0.9 0.15];

% simulate experiment with model one

parameters = [0.2 0.3 0.75 0.5 0.8];
measurement_times = 0:0.25:10;

options = odeset('AbsTol',1e-9,'RelTol',1e-12,'NonNegative',[1 2]); % set solver options

[t,x1] = ode45(@model_one,measurement_times,init,options,parameters);

% add some noise to the simulated values to generate virtual experimental data

x1_ = x1+randn(size(x1)).*x1.*0.01;

% visualize experimental data

figure('Name','Expermental data generated with model one')
[t_help,x1_help] = ode45(@model_one,linspace(measurement_times(1),measurement_times(end),1000),init,options,parameters);
plot(t,x1_(:,1),'ko','MarkerSize',4)
hold on
plot(t,x1_(:,2),'ko','MarkerFaceColor','k','MarkerSize',4)
legend('x1','x2',2)
plot(t_help,x1_help,'k--')
ylim([0 4])

% initial guess

p0 = rand(1,5);

% set upper and lower bounds for the parameters

ub = [1 1 1 1 1];
lb = [0 0 0 0 0];

% perform parameter estimation using the fmincon optimization algorithm

[p2_fmincon,J_fmincon] = parameter_estimation(p0,x1_,measurement_times,init,lb,ub,'fmincon');

% plot result of parameter estimation

[t,x2_fmincon] = ode45(@model_one,measurement_times,init,options,p2_fmincon);

figure('Name','Simulation result obtained with model parameters with ''fmincon'' algorithm')
plot(t,x1_(:,1),'ko','MarkerSize',4)
hold on
plot(t,x1_(:,2),'ko','MarkerFaceColor','k','MarkerSize',4)
legend('x1','x2',4)
plot(t,x2_fmincon,'k--')
plot(t_help,x1_help,'k:')
ylim([0 4])

% perform parameter estimation using the simpsa optimization algorithm

[p2_simpsa,J_simpsa] = parameter_estimation(p0,x1_,measurement_times,init,lb,ub,'SIMPSA');

% plot result of parameter estimation

[t,x2_simpsa] = ode45(@model_one,measurement_times,init,options,p2_simpsa);

figure('Name','Simulation result obtained with model parameters with ''SIMPSA'' algorithm')
plot(t,x1_(:,1),'ko','MarkerSize',4)
hold on
plot(t,x1_(:,2),'ko','MarkerFaceColor','k','MarkerSize',4)
legend('x1','x2',4)
plot(t,x2_simpsa,'k--')
plot(t_help,x1_help,'k:')
ylim([0 4])

% perform parameter estimation using the shuffled complex evolution algorithm

[p2_sce,J_sce] = parameter_estimation(p0,x1_,measurement_times,init,lb,ub,'SCE');

% plot result of parameter estimation

[t,x2_sce] = ode45(@model_one,measurement_times,init,options,p2_simpsa);

figure('Name','Simulation result obtained with model parameters with ''SCE'' algorithm')
plot(t,x1_(:,1),'ko','MarkerSize',4)
hold on
plot(t,x1_(:,2),'ko','MarkerFaceColor','k','MarkerSize',4)
legend('x1','x2',4)
plot(t,x2_sce,'k--')
plot(t_help,x1_help,'k:')
ylim([0 4])

% perform parameter estimation using the particle swarm optimization algorithm

[p2_pso,J_pso] = parameter_estimation(p0,x1_,measurement_times,init,lb,ub,'PSO');

% plot result of parameter estimation

[t,x2_pso] = ode45(@model_one,measurement_times,init,options,p2_simpsa);

figure('Name','Simulation result obtained with model parameters with ''PSO'' algorithm')
plot(t,x1_(:,1),'ko','MarkerSize',4)
hold on
plot(t,x1_(:,2),'ko','MarkerFaceColor','k','MarkerSize',4)
legend('x1','x2',4)
plot(t,x2_pso,'k--')
plot(t_help,x1_help,'k:')
ylim([0 4])





