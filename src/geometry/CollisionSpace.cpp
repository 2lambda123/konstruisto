#include "CollisionSpace.hpp"

namespace geometry {

void CollisionSpace::insert(Collidable::ptr collidable_ptr) noexcept {
  collidables.push_back(collidable_ptr);
}

bool CollisionSpace::remove(const Collidable& collidable) noexcept {
  auto to_remove = std::find_if(collidables.begin(), collidables.end(),
                                [&](const Collidable::ptr& ptr) { return *ptr == collidable; });
  if (to_remove == collidables.end()) {
    return false;
  }

  collidables.erase(to_remove);
  return true;
}

void CollisionSpace::clear() noexcept {
  collidables.clear();
}

bool CollisionSpace::if_collides(const Collidable& collidable) const noexcept {
  return std::any_of(collidables.begin(), collidables.end(), [collidable](auto& other_collidable_ptr) {
    return collidable.test_collision(*other_collidable_ptr);
  });
}
}