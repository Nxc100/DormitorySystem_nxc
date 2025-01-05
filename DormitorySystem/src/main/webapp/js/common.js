// 通用函数
function initDashboard() {
  // 添加卡片悬停效果
  document.querySelectorAll('.card').forEach(card => {
    card.addEventListener('mouseenter', function () {
      this.style.transform = 'translateY(-5px)';
    });

    card.addEventListener('mouseleave', function () {
      this.style.transform = 'translateY(0)';
    });
  });

  // 添加退出登录确认
  document.querySelector('.logout-btn').addEventListener('click', function (e) {
    if (!confirm('确定要退出登录吗？')) {
      e.preventDefault();
    }
  });
}

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', initDashboard); 