function twoSum(nums: number[], target: number): any {
    for (let i = 0; i < nums.length; i++) {
        let a = nums[i]
        for (let j = i+1; j < nums.length; j++) {
            let b = nums[j]
            if (a + b == target) {
              return [i, j]
            }
        }
    }
}
