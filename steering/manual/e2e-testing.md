---
inclusion: manual
---

# E2E Testing Skill

Activate this skill when writing end-to-end tests with Playwright or similar tools.

## Test Structure

### Page Object Model
Encapsulate page interactions in reusable objects:

```typescript
class ProductPage {
  constructor(private page: Page) {}

  async navigate(productId: string) {
    await this.page.goto(`/products/${productId}`);
  }

  async addToCart() {
    await this.page.click('[data-testid="add-to-cart"]');
  }

  async getPrice() {
    return this.page.textContent('[data-testid="price"]');
  }
}
```

### Test Pattern

```typescript
test('user can add product to cart', async ({ page }) => {
  // Arrange — navigate to product
  const productPage = new ProductPage(page);
  await productPage.navigate('123');

  // Act — add to cart
  await productPage.addToCart();

  // Assert — verify cart updated
  await expect(page.locator('[data-testid="cart-count"]'))
    .toHaveText('1');
});
```

## Best Practices

- Use `data-testid` attributes for test selectors (stable, not tied to styling)
- Wait for elements explicitly — don't use arbitrary timeouts
- Test user journeys, not implementation details
- Keep tests independent — each test starts from a clean state
- Use fixtures for common setup (login, seed data)

## What to Test E2E

- Critical user flows (signup, login, checkout, core features)
- Cross-page navigation
- Form submissions with validation
- Error states and recovery
- Responsive behavior on different viewports

## What NOT to Test E2E

- Individual component rendering (use unit tests)
- API response formats (use integration tests)
- CSS styling details
- Every possible input combination

## Debugging Failed Tests

1. Check screenshots/videos from test run
2. Look at network requests for failed API calls
3. Check console errors in the browser
4. Run the specific test in headed mode for visual debugging
5. Add `await page.pause()` to stop at a specific point
