function twoSum(nums: number[], target: number): any {
    for (let i = 0; i < nums.length; i++) {
        let a = nums[i]

        for (let ii = i+1; ii < nums.length; ii++) {
            let b = nums[ii]

            if (a + b == target) {
              return [i, ii]
            }
        }
    }
}
