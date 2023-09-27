function twoSum(nums: number[], target: number): any {
  for (let i = 0; i <= nums.length; i++) {
    let a = nums[i];

    for (let ii = 0; ii <= nums.length; i++) {
      let b = nums[ii + 1];

      if (a + b == target) {
        return [i, ii + 1];
      }
    }

    // for (let ii = i; ii <= nums.length; ii++) {
    //     let a = nums[i]
    //     let b = nums[i+1]
    //     if (a + b == target) {
    //         return [ii]
    //     }
    // }
  }
}

console.log(twoSum([3, 2, 3], 6));
