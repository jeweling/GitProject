function generate_ensembles(setting)
fprintf('=============== %s ==================\n', mfilename);
result_dir = sprintf('result_%s', setting);
if ~exist(result_dir, 'dir')
    mkdir(result_dir);
end

%setpaths;

kernel_types = {'linear', 'poly'};
kernel_params = {0, 1.5:0.1:2.0};
 %kernel_params = {0, [0.5,0.7,1,1.2,1.5,1.7,2]};
 %kernel_params = {[0,], [0.5,0.6,0.7,0.8,1,1.2,1.5,1.7]};
models_all=[];
sv_all = [];
R =[];
tic
 


% C_set = [0.1 0.2 0.5 1 2 5 10 20 30 50];
C_set = [1e-4 1e-3 1e-2 1e-1  0.2 0.5 1 10 20 50];
N_set = [100];

for j = 1 : length(N_set)
    N = N_set(j);
    round=1;
    %data = load_data(setting,N,round);
    data = load ('comp_vs_rec1.mat');  
    for i = 1 : length(C_set)
        C = C_set(i);
       
        
        [models,rst,svs] = train_base_classifier(data, C,kernel_types, kernel_params);
        result{j,i} = rst;
        models_all=[models_all models];
        sv_all = [sv_all svs];
        %R=[R,cv_R];
        acc = [rst.acc]; ap = [rst.ap];
        sprintf('%s',acc);
        
        fprintf('acc = %g(%g) ap = %g(%g) @ N = %d, C = %g\n', mean(acc), std(acc), mean(ap), std(ap), N, C);
    end
end

model_file=fullfile(result_dir,'models_all.mat');
sv_file=fullfile(result_dir,'sv_all.mat');

save(model_file,'models_all');
save(sv_file, 'sv_all');
%save(strcat('classifier_',base_type,'_',dec2base(L,10),'_Re'),'R');


% mdsq(models_all, sv_all);
%show_result_svm_at(setting)

toc