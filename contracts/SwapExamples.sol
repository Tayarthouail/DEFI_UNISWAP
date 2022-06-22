// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;
pragma abicoder v2;


import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

contract swapExamples {


    ISwapRouter public constant swapRouter =
             ISwapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);


    address public constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address public constant WETH9 = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address public constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;


    // For this example we will set the pool fee to 0.3%
    // uint24 public constant poolFee = 3000;


    // @notice swapExactInputSingle swaps fixed amount of WETH9 for a maximum possible amount of DAI
    function swapExactInputSingle(uint256 amountIn) external returns (uint256 amountOut) {
       // msg.sender must approve this contract


       //Transfer the specified amount of WETH9 to this contract
       TransferHelper.safeTransferFrom(WETH9, msg.sender, address(this), amountIn);

       // The smart contract approves the router to spend WETH9
       TransferHelper.safeApprove(WETH9, address(swapRouter), amountIn);
       
       ISwapRouter.ExactInputSingleParams memory params = 
         ISwapRouter.ExactInputSingleParams({
             tokenIn: WETH9,
             tokenOut: DAI,
             fee: 3000,
             recipient: msg.sender,
             deadline: block.timestamp,
             amountIn: amountIn,
             amountOutMinimum: 0,
             sqrtPriceLimitX96:0
            });

        // The call to "exactInputSingle" executes the swap
        amountOut = swapRouter.exactInputSingle(params);

    }

}