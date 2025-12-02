# Union Shop - Development Progress

## Project Overview
This is a Flutter e-commerce application recreating the University of Portsmouth Students' Union shop website (shop.upsu.net) as part of coursework for modules M30235 and M32605.

**Target:** Responsive web app (primary mobile view, desktop compatible)  
**Framework:** Flutter/Dart  
**Repository:** https://github.com/bahaeldin189/union_shop  
**Started:** December 2, 2025

## ✅ Completed Features

### Basic Features (40% of functionality marks) - ALL COMPLETED ✅
- [x] **Static Homepage** (5%) - Homepage layout with hardcoded content, mobile-focused
- [x] **Static Navbar** (5%) - Reusable navbar component with navigation menu and functional routing
- [x] **About Us Page** (5%) - Complete page with UPSU information, services, and contact details
- [x] **Footer** (4%) - Responsive footer with links, contact info, and social media placeholders
- [x] **Collections Page** (5%) - Overview page showing product collections with grid layout
- [x] **Collection Detail Page** (5%) - Individual collection pages with products, filters, and dropdowns (static)
- [x] **Basic Product Page** (4%) - Single product display with static content
- [x] **Sale Collection** (4%) - Dedicated sale page with discounted products and promotional messaging
- [x] **Authentication UI** (3%) - Complete login and signup forms with validation (UI only)

### Testing Infrastructure
- [x] **Widget Tests Setup** - Fixed test files to match current implementation
- [x] **Test Coverage** - Basic tests for home and product pages
- [x] **Async Handling** - Added proper handling for network images in tests

### Development Setup
- [x] **Project Structure** - Clean Flutter project with proper file organization
- [x] **Component Architecture** - Reusable NavBar and Footer components
- [x] **Routing System** - Complete navigation between all basic pages
- [x] **Development Documentation** - This README_DEV.md for tracking progress

## 🚧 In Progress

Currently working on intermediate features to build dynamic functionality.

## 📋 Next Steps (Priority Order)

### Intermediate Features (35% of functionality marks)
- [ ] **Full Navigation System** (3%) - Complete routing between all pages (mostly done, needs collection detail routing)
- [ ] **Dynamic Collections** (6%) - Data-driven collections with sorting/filtering
- [ ] **Dynamic Collection Pages** (6%) - Product listings with functional widgets
- [ ] **Functional Product Pages** (6%) - Interactive dropdowns, counters, etc.
- [ ] **Shopping Cart** (6%) - Add to cart, view cart, basic functionality
- [ ] **Print Shack** (3%) - Text personalization with dynamic form updates
- [ ] **Responsiveness** (5%) - Desktop adaptation and responsive design
- [ ] **Full Navigation System** (3%) - Complete routing between all pages
- [ ] **Dynamic Collections** (6%) - Data-driven collections with sorting/filtering
- [ ] **Dynamic Collection Pages** (6%) - Product listings with functional widgets
- [ ] **Functional Product Pages** (6%) - Interactive dropdowns, counters, etc.
- [ ] **Shopping Cart** (6%) - Add to cart, view cart, basic functionality
- [ ] **Print Shack** (3%) - Text personalization with dynamic form updates
- [ ] **Responsiveness** (5%) - Desktop adaptation and responsive design

### Advanced Features (25% of functionality marks)
- [ ] **Authentication System** (8%) - Full user auth and account management
- [ ] **Cart Management** (6%) - Complete cart functionality with persistence
- [ ] **Search System** (4%) - Functional search across products

### Software Development Practices (25% of total marks)
- [ ] **Regular Git Commits** (8%) - Frequent, meaningful commits with clear messages
- [ ] **Comprehensive README** (5%) - Replace starter README with project documentation
- [ ] **Extensive Testing** (6%) - Full test coverage for all features
- [ ] **External Services** (6%) - Integration with at least 2 cloud services (Firebase, etc.)

## 🎯 Current Milestone Goals

### Week 1 (Dec 2-8, 2025)
- Complete all basic features (40% functionality)
- Establish proper Git workflow
- Set up project documentation

### Week 2 (Dec 9-15, 2025)  
- Implement intermediate features
- Add external service integrations
- Expand test coverage

### Week 3 (Dec 16-19, 2025)
- Advanced features and polish
- Final testing and documentation
- Demo preparation

## 💻 Technical Architecture

### Current Structure
```
lib/
├── main.dart           # Main app and homepage
└── product_page.dart   # Product detail page

test/
├── home_test.dart      # Homepage tests
└── product_test.dart   # Product page tests
```

### Planned Structure
```
lib/
├── main.dart
├── models/            # Data models
├── pages/             # Page widgets
│   ├── home/
│   ├── product/
│   ├── collections/
│   ├── auth/
│   └── cart/
├── widgets/           # Reusable components
│   ├── navbar/
│   ├── footer/
│   └── product_card/
├── services/          # External services integration
└── utils/             # Helper functions and constants
```

## 🧪 Testing Strategy

- **Unit Tests**: Core business logic and data models
- **Widget Tests**: UI components and user interactions  
- **Integration Tests**: End-to-end user flows
- **Network Mocking**: Handle external API calls in tests

## 📊 Progress Tracking

**Overall Completion: ~45%**
- Basic Features: 9/9 completed (100%) ✅
- Intermediate Features: 0/6 completed (0%)
- Advanced Features: 0/3 completed (0%)
- Software Practices: 3/4 completed (75%)

## 🔄 Development Workflow

1. **Feature Development**: Implement one feature at a time
2. **Testing**: Write/update tests for each feature
3. **Commit**: Regular commits with descriptive messages
4. **Documentation**: Update this file with progress
5. **Review**: Code review and refactoring

## 📝 Commit Message Convention

- `feat:` New features
- `fix:` Bug fixes  
- `test:` Testing changes
- `docs:` Documentation updates
- `refactor:` Code restructuring
- `style:` Formatting changes

## 🚀 Demo Preparation

- **Date**: Week 19 or 20 (Dec 12-19, 2025)
- **Duration**: 10 minutes maximum
- **Requirements**: Clone repository and run live demonstration
- **Focus**: Functionality over visual design

---
*Last updated: December 2, 2025*