// ssa-reduce-bug.slang
//TEST(compute):COMPARE_COMPUTE_EX:-slang -compute

//TEST_INPUT:ubuffer(data=[0 3 1 2 6 4 7 6], stride=4):dxbinding(0),glbinding(0)
//TEST_INPUT:ubuffer(data=[8 8 8 8 8 8 8 8], stride=4):dxbinding(1),glbinding(1),out

RWStructuredBuffer<int> inputBuffer;
RWStructuredBuffer<int> outputBuffer;

int2 reduce(int2 val)
{
	for(int ii = 0; ii < 4; ++ii)
	{
		if(inputBuffer[ii] != 8)
		{
			val.x = max(val.x, inputBuffer[ii]);
			val.y = min(val.y, inputBuffer[ii + 4]);
		}
	}
	return val;
}

[numthreads(4, 1, 1)]
void computeMain(uint3 dispatchThreadID : SV_DispatchThreadID)
{
	uint tid = dispatchThreadID.x;

	int2 inVal = int2(inputBuffer[tid], inputBuffer[tid + 4]);

	int2 outVal = reduce(inVal);

	outputBuffer[tid] = outVal.x;
	outputBuffer[tid + 4] = outVal.y;
}