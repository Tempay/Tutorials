require 'torch'  
require 'nn'      
require 'cunn'

----------------------------------------------------------------------

local modelSelect = 2

if modelSelect == 1 then
  model = nn.Sequential()
  model:add(nn.SpatialBatchNormalization(1)) 
  model:add(nn.SpatialConvolution(  1,   8, 5, 5, 2, 2)) 
  model:add(nn.ReLU(true))
  model:add(nn.SpatialBatchNormalization(8)) 
  model:add(nn.SpatialConvolution(  8,  32, 5, 5, 2, 2)) 
  model:add(nn.ReLU(true))
  model:add(nn.SpatialBatchNormalization(32)) 
  model:add(nn.SpatialConvolution( 32, 256, 5, 5, 1, 1))
  model:add(nn.ReLU(true))
  model:add(nn.SpatialBatchNormalization(256)) 
  model:add(nn.SpatialFullConvolution(256, 32, 5, 5, 1, 1))
  model:add(nn.ReLU(true))
  model:add(nn.SpatialBatchNormalization(32)) 
  model:add(nn.SpatialFullConvolution( 32,  8, 5, 5, 2, 2, 0, 0, 1, 1))
  model:add(nn.ReLU(true))
  model:add(nn.SpatialBatchNormalization(8)) 
  model:add(nn.SpatialFullConvolution(  8,  1, 5, 5, 2, 2, 0, 0, 1, 1))
  model:add(nn.Sigmoid())
elseif modelSelect == 2 then
  model = nn.Sequential()
  model:add(nn.SpatialBatchNormalization(1))
  model:add(nn.Reshape(1024))
  model:add(nn.Linear(1024, 256)) 
  model:add(nn.ReLU(true))
  model:add(nn.Linear(256, 1024))  
  model:add(nn.Reshape(1, 32, 32)) 
  model:add(nn.Sigmoid())
end

model:cuda()

----------------------------------------------------------------------

criterion = nn.MSECriterion()
criterion:cuda()

----------------------------------------------------------------------

print 'loss function:'
print(criterion)

----------------------------------------------------------------------

print 'model:'
print(model)

----------------------------------------------------------------------

