function data = load_data(setting,N,round)

%% 使用数据集comp_vs_rec.mat，这里要把代码重新改

DATA=load ('comp_vs_rec1.mat'); 

feat = [DATA.dataset.src_X;DATA.dataset.tar_X];
data.Y  = [DATA.dataset.src_labels;DATA.dataset.tar_labels];
data.S = full(feat*feat');

data.num_src=size(DATA.dataset.src_X,1);
data.num_tar= size(DATA.dataset.tar_X,1);
data.src_index = (1:data.num_src)';
%正例是comp数据集，负例是rec数据集  这里我们选2000作为tar正负例的分界
% % data.tar_train_index = [(round-1)*10+1 : (round-1)*10+N, 2000+(round-1)*10+1 : 2000+(round-1)*10+N]';
% % data.tar_train_index = data.tar_train_index + data.num_src;
% % data.tar_test_index = setdiff(data.num_src + (1:data.num_tar), data.tar_train_index);
% % data.train_index = [data.src_index;data.tar_train_index];
% % data.test_index = data.tar_test_index;
%% 方法一：只用有标号数据做剪枝集

% data.new_cv_index = data.tar_train_index;
% 
% myperm = randperm(length(data.test_index));
% data.test_index = data.test_index(myperm);

data.setting = setting;   

% 划分新问题
% myperm = randperm(length(data.test_index));
% data.num_train = floor(0.6 * length(data.test_index));
% 
% data.new_train_index = data.test_index(myperm(1 : data.num_train))';                                   % 新问题上的训练集
% data.new_cv_index = data.test_index(myperm(data.num_train+1 : floor(0.8 * length(data.test_index))))'; % 新问题上的验证集
% 
% data.new_test_index = data.test_index(myperm(floor(0.8 * length(data.test_index))+1):end)';            % 新问题上的测试集
% 







