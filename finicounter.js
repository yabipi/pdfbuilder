/**
 * DevOps Toolbox - 网站访问量统计
 * API 服务器: devops.icodelib.cn
 */

(function() {
    'use strict';

    // 配置：API 地址
    var API_BASE_URL = window.DEVOPS_COUNTER_API || 'https://devops.icodelib.cn/api/v1/website';
    
    // 配置：显示元素的 ID（可以自定义）
    var VIEWS_ELEMENT_ID = window.DEVOPS_COUNTER_ELEMENT_ID || 'finicount_views';

    /**
     * 格式化数字，添加千分位分隔符
     * @param {number} num - 要格式化的数字
     * @returns {string} 格式化后的字符串
     */
    function formatNumber(num) {
        return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    }

    /**
     * 获取网站域名
     * @returns {string} 域名
     */
    function getHostname() {
        return window.location.hostname;
    }

    /**
     * 获取访问量
     * @returns {Promise<Object>} 包含 views 的对象
     */
    async function getViews() {
        var host = getHostname();
        var url = API_BASE_URL + '/counter?host=' + encodeURIComponent(host);
        
        try {
            var res = await fetch(url, {
                method: 'GET',
                headers: {
                    'Accept': 'application/json',
                },
                // 不发送 credentials，避免 CORS 问题
                credentials: 'omit'
            });
            
            if (!res.ok) {
                throw new Error('HTTP error! status: ' + res.status);
            }
            
            return await res.json();
        } catch (error) {
            console.error('获取访问量失败:', error);
            return { views: 0 };
        }
    }

    /**
     * 渲染访问量到页面
     */
    async function renderViews() {
        try {
            var res = await getViews();
            var elem = document.getElementById(VIEWS_ELEMENT_ID);
            
            if (elem !== null && elem !== undefined) {
                var views = res.views || 0;
                elem.innerText = formatNumber(views);
                
                // 触发自定义事件，方便其他脚本监听
                var event = new CustomEvent('devopsCounterUpdated', {
                    detail: { views: views }
                });
                document.dispatchEvent(event);
            } else {
                console.warn('未找到访问量显示元素，ID: ' + VIEWS_ELEMENT_ID);
            }
        } catch (error) {
            console.error('渲染访问量失败:', error);
        }
    }

    // 页面加载完成后执行
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', renderViews);
    } else {
        // DOM 已经加载完成，直接执行
        renderViews();
    }

    // 暴露全局函数，方便手动调用
    window.devopsCounter = {
        refresh: renderViews,
        formatNumber: formatNumber,
        getHostname: getHostname
    };
})();

